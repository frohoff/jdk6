/*
 * Copyright 2007 Sun Microsystems, Inc.  All Rights Reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This code is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 only, as
 * published by the Free Software Foundation.  Sun designates this
 * particular file as subject to the "Classpath" exception as provided
 * by Sun in the LICENSE file that accompanied this code.
 *
 * This code is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * version 2 for more details (a copy is included in the LICENSE file that
 * accompanied this code).
 *
 * You should have received a copy of the GNU General Public License version
 * 2 along with this work; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara,
 * CA 95054 USA or visit www.sun.com if you need additional information or
 * have any questions.
 */

/* @test
   @summary Test ModelSource(ModelIdentifier,boolean) constructor */

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.sound.sampled.*;

import com.sun.media.sound.*;

public class NewModelSourceModelIdentifierBoolean {

	public static void main(String[] args) throws Exception {
		ModelSource src = new ModelSource(ModelSource.SOURCE_NOTEON_KEYNUMBER,ModelStandardTransform.DIRECTION_MAX2MIN);
		if(src.getIdentifier() != ModelSource.SOURCE_NOTEON_KEYNUMBER)
			throw new RuntimeException("src.getIdentifier() doesn't return ModelSource.SOURCE_NOTEON_KEYNUMBER!");
		if(!(src.getTransform() instanceof ModelStandardTransform))
			throw new RuntimeException("src.getTransform() doesn't return object which is instance of ModelStandardTransform!");
		ModelStandardTransform trans = (ModelStandardTransform)src.getTransform();
		if(trans.getDirection() != ModelStandardTransform.DIRECTION_MAX2MIN)
			throw new RuntimeException("trans.getDirection() doesn't return ModelStandardTransform.DIRECTION_MAX2MIN!");
	}
}
