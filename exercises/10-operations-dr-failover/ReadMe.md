DR Failover
===
In this exercise, you will do a DR failover. This is normally done in case of a disaster.
In a normal deployment a a loadbalancer would be used to switch between the primary and secondary vault clusters, but this is dependant on the environment.

## DR failover
Now we switch which vault cluster is the primary and which is the secondary. We would do this in case of a disaster.
Read the [Disaster Recovery Failover](https://developer.hashicorp.com/vault/tutorials/enterprise/disaster-recovery-replication-failover) documentation.

Use the vault cli to do the failover.
