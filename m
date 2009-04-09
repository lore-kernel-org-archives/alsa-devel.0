From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Add support Voice DAI
Date: Thu, 09 Apr 2009 22:54:35 +0900
Message-ID: <49DDFE1B.2090501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E614924453
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 15:54:48 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KHU006S26MZPL@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 09 Apr 2009 22:54:36 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KHU00HZA6MZNP@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 09 Apr 2009 22:54:35 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

Hi,

I added Voice DAI to support the PCM voice interface of the twl4030 codec.
I tried this work with TRM, but there can be some miscomprehension. 

Please review.

Thanks.
