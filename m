From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Fix typo in late revision WM8994
 DAC2R name
Date: Wed, 09 Mar 2011 20:24:55 +0000
Message-ID: <1299702295.3360.191.camel@odin>
References: <1299697884-15482-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FAC11039D8
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 21:24:59 +0100 (CET)
Received: by wwj40 with SMTP id 40so885027wwj.20
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 12:24:58 -0800 (PST)
In-Reply-To: <1299697884-15482-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2011-03-09 at 19:11 +0000, Mark Brown wrote:
> Without this fix the driver won't instantiate properly on relevant
> devices.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@ti.com>
