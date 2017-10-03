from galaxy.jobs import JobDestination
import os

def k8s_wrapper(resource_params):
    # Allocate extra time
    resource_params['docker_enabled'] = True
    return JobDestination(runner="k8s", params=resource_params)
