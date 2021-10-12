const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const staffSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  phone: {
    type: String,
    required: false,
    trim: true,
  },
  email: {
    type: String,
    unique: true,
    required: true,
    dropDups: true,
    trim: true,
    lowercase: true,
    validate(value) {
      return validator.isEmail(value);
    },
  },
  role: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
    trim: true,
    validate(value) {
      return validator.isStrongPassword(value, {
        minSymbols: 0,
      });
    },
  },
  tokenAuths: [
    {
      token: {
        type: String,
        required: true,
      },
    },
  ],
  tokenRefeshs: [
    {
      token: {
        type: String,
        required: true,
      },
    },
  ],
});

/**
 * Remove password and token from User model
 * before send it back
 *
 */
staffSchema.methods.toJSON = function () {
  const staffObject = this.toObject();
  delete staffObject.pincode;
  delete staffObject.tokenAuths;
  delete staffObject.tokenRefeshs;
  delete staffObject.password;
  return staffObject;
};

/**
 * @param {String} email
 * @param {String} password
 * @returns {Staff} staff - staff object if there is an staff correspond deviceCode
 */
staffSchema.statics.findByCredentials = async function (email, password) {
  const staff = await Staff.findOne({ email: email });
  if (!staff) {
    throw new Error("The Staff does not exist");
  }
  const isMatchPassword = await bcrypt.compare(password, staff.password);
  if (!isMatchPassword) {
    throw new Error("Password is not correct");
  }
  return staff;
};

/**
 * Generate new token auth for staff
 *  @returns {String} token - the token auth
 */
staffSchema.methods.getNewTokenAuth = async function () {
  const staff = this;
  const newToken = jwt.sign(
    { _id: staff._id.toString() },
    process.env.JWT_SECRET_KEY,
    {
      expiresIn: "30m",
    }
  );
  staff.tokenAuths.push({ token: newToken });
  await staff.save();
  return newToken;
};

/**
 * Generate new token refesh for staff
 *  @returns {String} token - the token auth
 */
staffSchema.methods.getNewTokenRefesh = async function () {
  const staff = this;
  const newToken = jwt.sign(
    { _id: staff._id.toString() },
    process.env.JWT_SECRET_KEY,
    {
      expiresIn: "7d",
    }
  );
  staff.tokenRefeshs.push({ token: newToken });
  await staff.save();
  return newToken;
};

/**
 * Request to get new token auth from token refesh
 * @param {String} tokenRefesh
 * @returns {String} token - Token is generated by token refesh if it not expire
 */
staffSchema.statics.getNewTokenFromTokenRefesh = async function (tokenRefesh) {
  try {
    const data = jwt.verify(tokenRefesh, process.env.JWT_SECRET_KEY);
    const staff = Staff.findOne({ _id: data._id });
    if (!staff) throw new Error("The Staff does not exist");
    let newToken = await staff.getNewTokenAuth();
    return newToken;
  } catch (e) {
    throw new Error(err.message);
  }
};

/**
 * Hash the password before save
 * only hash if password is modified
 */
staffSchema.pre("save", async function (next) {
  const staff = this;
  if (staff.isModified("password")) {
    staff.password = await bcrypt.hash(staff.password, 8);
  }
  next();
});

const Staff = mongoose.model("Staff", staffSchema);

module.exports = Staff;
