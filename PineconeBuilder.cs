// Copyright (c) Microsoft. All rights reserved.

using Docker.DotNet.Models;
using DotNet.Testcontainers.Builders;
using DotNet.Testcontainers.Configurations;

namespace PineconeIntegrationTests.Support.TestContainer;

public sealed class PineconeBuilder : ContainerBuilder<PineconeBuilder, PineconeContainer, PineconeConfiguration>
{
    // public const string PineconeImage = "ghcr.io/pinecone-io/pinecone-local:v0.7.0";
    public const string PineconeImage = "ghcr.io/pinecone-io/pinecone-local:latest";
    public const ushort PineconePort = 5080;

    public PineconeBuilder() : this(new PineconeConfiguration()) => this.DockerResourceConfiguration = this.Init().DockerResourceConfiguration;

    private PineconeBuilder(PineconeConfiguration dockerResourceConfiguration) : base(dockerResourceConfiguration)
        => this.DockerResourceConfiguration = dockerResourceConfiguration;

    public override PineconeContainer Build()
    {
        this.Validate();
        return new PineconeContainer(this.DockerResourceConfiguration);
    }

    protected override PineconeBuilder Init()
        => base.Init()
            .WithImage(PineconeImage)
            .WithPortBinding(PineconePort, true);

    protected override PineconeBuilder Clone(IResourceConfiguration<CreateContainerParameters> resourceConfiguration)
        => this.Merge(this.DockerResourceConfiguration, new PineconeConfiguration(resourceConfiguration));

    protected override PineconeBuilder Merge(PineconeConfiguration oldValue, PineconeConfiguration newValue)
        => new(new PineconeConfiguration(oldValue, newValue));

    protected override PineconeConfiguration DockerResourceConfiguration { get; }

    protected override PineconeBuilder Clone(IContainerConfiguration resourceConfiguration)
        => this.Merge(this.DockerResourceConfiguration, new PineconeConfiguration(resourceConfiguration));
}
