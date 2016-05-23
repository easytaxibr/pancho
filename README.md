# pancho

This is a simple project for iOS applicants.

## The Test

It's quite easy. Fork this repo and make the following changes

- Run this server `https://github.com/easytaxibr/mockrista` in your localhost
- Consume the `taxi-position/the-taxi` API async
- The `taxi-positon/the-taxi` API in each call will provide a `taxi-driver` object that has a `position` node. This `position`
corresponds the position of the taxi in that given moment. 

## Milestones

1 - Consume the API with Async Calls with a pooling with 3 secs delay. Create a class for the `taxi-driver` and plot 
the positions in the map.

2 - Use the `pin_taxi_regular` image for plot the `taxi-driver` positions in the map with bearing.

3 - Make the transition of the taxi pin on the map animated and smoothest as possible.
