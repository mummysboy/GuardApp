import { ModelInit, MutableModel, __modelMeta__, ManagedIdentifier } from "@aws-amplify/datastore";
// @ts-ignore
import { LazyLoading, LazyLoadingDisabled, AsyncCollection, AsyncItem } from "@aws-amplify/datastore";

export enum Role {
  ADMIN = "ADMIN",
  BUSINESS_OWNER = "BUSINESS_OWNER",
  BUSINESS_STAFF = "BUSINESS_STAFF",
  WORKER = "WORKER"
}

export enum ShiftState {
  DRAFT = "DRAFT",
  OPEN = "OPEN",
  REQUESTED = "REQUESTED",
  ASSIGNED = "ASSIGNED",
  COMPLETED = "COMPLETED",
  DISPUTED = "DISPUTED",
  CLOSED = "CLOSED"
}



type EagerUser = {
  readonly [__modelMeta__]: {
    identifier: ManagedIdentifier<User, 'id'>;
  };
  readonly id: string;
  readonly tenantId: string;
  readonly role: Role | keyof typeof Role;
  readonly email: string;
  readonly firstName?: string | null;
  readonly lastName?: string | null;
  readonly phone?: string | null;
  readonly createdAt: string;
  readonly updatedAt: string;
  readonly shifts?: (Shift | null)[] | null;
}

type LazyUser = {
  readonly [__modelMeta__]: {
    identifier: ManagedIdentifier<User, 'id'>;
  };
  readonly id: string;
  readonly tenantId: string;
  readonly role: Role | keyof typeof Role;
  readonly email: string;
  readonly firstName?: string | null;
  readonly lastName?: string | null;
  readonly phone?: string | null;
  readonly createdAt: string;
  readonly updatedAt: string;
  readonly shifts: AsyncCollection<Shift>;
}

export declare type User = LazyLoading extends LazyLoadingDisabled ? EagerUser : LazyUser

export declare const User: (new (init: ModelInit<User>) => User) & {
  copyOf(source: User, mutator: (draft: MutableModel<User>) => MutableModel<User> | void): User;
}

type EagerShift = {
  readonly [__modelMeta__]: {
    identifier: ManagedIdentifier<Shift, 'id'>;
  };
  readonly id: string;
  readonly tenantId: string;
  readonly title: string;
  readonly location: string;
  readonly startAt: string;
  readonly endAt: string;
  readonly rate: number;
  readonly state: ShiftState | keyof typeof ShiftState;
  readonly userId: string;
  readonly user?: User | null;
  readonly createdAt: string;
  readonly updatedAt: string;
}

type LazyShift = {
  readonly [__modelMeta__]: {
    identifier: ManagedIdentifier<Shift, 'id'>;
  };
  readonly id: string;
  readonly tenantId: string;
  readonly title: string;
  readonly location: string;
  readonly startAt: string;
  readonly endAt: string;
  readonly rate: number;
  readonly state: ShiftState | keyof typeof ShiftState;
  readonly userId: string;
  readonly user: AsyncItem<User | undefined>;
  readonly createdAt: string;
  readonly updatedAt: string;
}

export declare type Shift = LazyLoading extends LazyLoadingDisabled ? EagerShift : LazyShift

export declare const Shift: (new (init: ModelInit<Shift>) => Shift) & {
  copyOf(source: Shift, mutator: (draft: MutableModel<Shift>) => MutableModel<Shift> | void): Shift;
}