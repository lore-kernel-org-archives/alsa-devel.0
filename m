From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: Initial WM8958 audio
	configuration
Date: Fri, 26 Nov 2010 17:49:03 +0000
Message-ID: <1290793743.3298.53.camel@odin>
References: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6165B2440F
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 18:49:13 +0100 (CET)
Received: by wyi11 with SMTP id 11so2201519wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 09:49:12 -0800 (PST)
In-Reply-To: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-26 at 15:21 +0000, Mark Brown wrote:
> The WM8958 is a WM8994 derivative. This patch merely ensures that some
> revision specific configuration for WM8994 is not enabled on WM8994,
> additional patches will add support for the new features introduced on
> the WM8958.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
