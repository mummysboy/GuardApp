// @ts-check
import { initSchema } from '@aws-amplify/datastore';
import { schema } from './schema';

const Role = {
  "ADMIN": "ADMIN",
  "BUSINESS_OWNER": "BUSINESS_OWNER",
  "BUSINESS_STAFF": "BUSINESS_STAFF",
  "WORKER": "WORKER"
};

const ShiftState = {
  "DRAFT": "DRAFT",
  "OPEN": "OPEN",
  "REQUESTED": "REQUESTED",
  "ASSIGNED": "ASSIGNED",
  "COMPLETED": "COMPLETED",
  "DISPUTED": "DISPUTED",
  "CLOSED": "CLOSED"
};

const { User, Shift } = initSchema(schema);

export {
  User,
  Shift,
  Role,
  ShiftState
};