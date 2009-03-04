From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 0/9] S3C24XX/S3C64XX updates
Date: Wed, 04 Mar 2009 00:49:25 +0000
Message-ID: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 54EF524407
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is a set of patches for 2.6.30 to add more
s3c24xx machine support and support for the S3C64XX
series of SoC.

It would be very useful to get the header moves merged
as soon as possible, to help clear out the old ARM
include directories (and make it easier for the merges
from other s3c branches that need to take place in the
merge window). As such, they're only moves and should
not affect the actual build.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
