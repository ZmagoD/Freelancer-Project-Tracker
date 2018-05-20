import ReactOnRails from 'react-on-rails';

import WeekPlannerApp from '../bundles/WeekPlanner/startup/WeekPlannerApp';

// This is how react_on_rails can see the WeekPlanner in the browser.
ReactOnRails.register({
  WeekPlannerApp: WeekPlannerApp,
});
