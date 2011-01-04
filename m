From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ALSA: ASoC: Fix SmartQ compilation
Date: Tue, 04 Jan 2011 16:45:00 +0000
Message-ID: <1294159500.3490.350.camel@odin>
References: <4d20d689.cc7e0e0a.6f59.4a1d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 2D7322446B
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 17:45:04 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so14263665wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 08:45:04 -0800 (PST)
In-Reply-To: <4d20d689.cc7e0e0a.6f59.4a1d@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-01-02 at 20:48 +0100, Maurus Cuelenaere wrote:
> This makes the SmartQ sound driver compile again with recent ASoC changes.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  sound/soc/s3c24xx/smartq_wm8987.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
