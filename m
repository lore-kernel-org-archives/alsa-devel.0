From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] regulator: Clean up logging a bit
Date: Tue, 21 Dec 2010 14:47:08 +0000
Message-ID: <1292942828.3296.45.camel@odin>
References: <1292601852-21905-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B95410380D
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 15:47:14 +0100 (CET)
Received: by wwe15 with SMTP id 15so3918267wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 06:47:12 -0800 (PST)
In-Reply-To: <1292601852-21905-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-12-17 at 16:04 +0000, Mark Brown wrote:
> The recent introduction of standard regulator API logging macros means
> that all our log messages have at least the function name in them and
> logging that the constraints are for the regulator API is probably a
> bit much.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
