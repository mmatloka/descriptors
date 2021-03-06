/*
 * JBoss, Home of Professional Open Source
 * Copyright 2011, Red Hat Middleware LLC, and individual contributors
 * by the @authors tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.jboss.shrinkwrap.descriptor.api;

import java.io.OutputStream;

/**
 * An entity capable of exporting a {@link Descriptor} to an {@link OutputStream}.
 *
 * @param <T>
 *            {@link Descriptor} type supported
 * @author <a href="mailto:alr@jboss.org">Andrew Lee Rubinger</a>
 */
public interface DescriptorExporter<T extends Descriptor> {

    /**
     * Exports the specified {@link Descriptor} to the specified {@link OutputStream}.
     *
     * @param descriptor
     * @param out
     * @throws DescriptorExportException
     *             If an error occurred during export
     * @throws IllegalArgumentException
     *             If either argument is not specified
     */
    void to(T descriptor, OutputStream out) throws DescriptorExportException, IllegalArgumentException;
}
