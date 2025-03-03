// Copyright (c) Microsoft. All rights reserved.

using Docker.DotNet.Models;
using DotNet.Testcontainers.Configurations;

namespace PineconeIntegrationTests.Support.TestContainer;

public sealed class PineconeConfiguration : ContainerConfiguration
{
    /// <summary>
    /// Initializes a new instance of the <see cref="PineconeConfiguration" /> class.
    /// </summary>
    public PineconeConfiguration()
    {
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="PineconeConfiguration" /> class.
    /// </summary>
    /// <param name="resourceConfiguration">The Docker resource configuration.</param>
    public PineconeConfiguration(IResourceConfiguration<CreateContainerParameters> resourceConfiguration)
        : base(resourceConfiguration)
    {
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="PineconeConfiguration" /> class.
    /// </summary>
    /// <param name="resourceConfiguration">The Docker resource configuration.</param>
    public PineconeConfiguration(IContainerConfiguration resourceConfiguration)
        : base(resourceConfiguration)
    {
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="PineconeConfiguration" /> class.
    /// </summary>
    /// <param name="resourceConfiguration">The Docker resource configuration.</param>
    public PineconeConfiguration(PineconeConfiguration resourceConfiguration)
        : this(new PineconeConfiguration(), resourceConfiguration)
    {
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="PineconeConfiguration" /> class.
    /// </summary>
    /// <param name="oldValue">The old Docker resource configuration.</param>
    /// <param name="newValue">The new Docker resource configuration.</param>
    public PineconeConfiguration(PineconeConfiguration oldValue, PineconeConfiguration newValue)
        : base(oldValue, newValue)
    {
    }
}
