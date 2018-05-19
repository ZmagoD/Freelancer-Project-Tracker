import { createStore } from 'redux';
import weekPlannerReducer from '../reducers/weekPlannerReducer';

const configureStore = (railsProps) => (
  createStore(weekPlannerReducer, railsProps)
);

export default configureStore;
