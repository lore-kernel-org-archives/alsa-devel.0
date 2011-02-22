From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Remove card from
 snd_soc_dapm_set_bias_level()
Date: Tue, 22 Feb 2011 09:27:09 +0000
Message-ID: <1298366829.3353.6.camel@odin>
References: <>
	<1298058913-22393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 958041037EE
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 10:27:13 +0100 (CET)
Received: by wwe15 with SMTP id 15so6806753wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 01:27:13 -0800 (PST)
In-Reply-To: <1298058913-22393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2011-02-18 at 19:55 +0000, Mark Brown wrote:
> We can get the card from the DAPM context so don't bother passing it as
> an argument.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
