From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 3/3] ARM: DaVinci: ASoC: Add machine driver
 support for DM646x
Date: Thu, 2 Apr 2009 20:11:06 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B0E4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 766CE10387D
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 16:44:56 +0200 (CEST)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n32Eimto021822
	for <alsa-devel@alsa-project.org>; Thu, 2 Apr 2009 09:44:54 -0500
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org


Please ignore this patch since the patch number is wrong.

I will re-submit the same patch with proper numbering.

Regards
Naresh


This patch does the following:
(1) Add support for the DM646x machine
(2)Introduce the platform driver model to get platform data for all the machines
including dm355 and dm644x.

Signed-off-by: Naresh Medisetty naresh@ti.com
---
_______________________________________________
Davinci-linux-open-source mailing list
Davinci-linux-open-source@linux.davincidsp.com
http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
