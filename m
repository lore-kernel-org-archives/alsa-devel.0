From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8580: Fix R8 initial value
Date: Thu, 09 Dec 2010 10:09:16 +0000
Message-ID: <1291889356.3271.22.camel@odin>
References: <1291885672-7198-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C3F1D103C5C
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 11:09:19 +0100 (CET)
Received: by wyi11 with SMTP id 11so2077859wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 02:09:19 -0800 (PST)
In-Reply-To: <1291885672-7198-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: sbkim73@samsung.com, sw.youn@samsung.com, alsa-devel@alsa-project.org, kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-09 at 18:07 +0900, Jassi Brar wrote:
> From: Seungwhan Youn <sw.youn@samsung.com>
> 
> Acc to WM8580 manual, the default value for R8 is 0x10, not 0x1c.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
