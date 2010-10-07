From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: Staticise CS4270 DAI
Date: Thu, 7 Oct 2010 15:06:23 -0500
Message-ID: <4CAE283F.40900@freescale.com>
References: <1286407557-30413-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B514103855
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 22:06:34 +0200 (CEST)
Received: from mail67-va3 (localhost.localdomain [127.0.0.1])	by
	mail67-va3-R.bigfish.com (Postfix) with ESMTP id 0EB859E03FC	for
	<alsa-devel@alsa-project.org>; Thu,  7 Oct 2010 20:06:28 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.244])	by
	mail67-va3.bigfish.com (Postfix) with ESMTP id E5E7C1C6804C	for
	<alsa-devel@alsa-project.org>; Thu,  7 Oct 2010 20:06:27 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o97K6OoR012847	for <alsa-devel@alsa-project.org>;
	Thu, 7 Oct 2010 13:06:24 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o97K6Oph014146	for <alsa-devel@alsa-project.org>;
	Thu, 7 Oct 2010 15:06:24 -0500 (CDT)
In-Reply-To: <1286407557-30413-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> It's not needed with multi-component.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
