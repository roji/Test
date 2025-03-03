// Copyright (c) Microsoft. All rights reserved.

using System;
using DotNet.Testcontainers.Containers;

namespace PineconeIntegrationTests.Support.TestContainer;

public class PineconeContainer(PineconeConfiguration configuration) : DockerContainer(configuration)
{
    public Uri Uri => new UriBuilder(Uri.UriSchemeHttp, this.Hostname, this.GetMappedPublicPort(PineconeBuilder.PineconePort)).Uri;
}
