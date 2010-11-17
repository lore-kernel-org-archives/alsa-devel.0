From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: davinci: fixes for multi-component
Date: Wed, 17 Nov 2010 18:42:16 +0000
Message-ID: <20101117184216.GD19488@rakim.wolfsonmicro.main>
References: <1289910429-29347-1-git-send-email-chris@edesix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3900D1037EC
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 19:42:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289910429-29347-1-git-send-email-chris@edesix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Paulson-Ellis <chris@edesix.com>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, miguel.aguilar@ridgerun.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 16, 2010 at 12:27:09PM +0000, Chris Paulson-Ellis wrote:
> Multi-component commit f0fba2ad broke a few things which this patch should
> fix. Tested on the DM355 EVM. I've been as careful as I can, but it would be
> good if those with access to other Davinci boards could test.

Applied on the basis that we can always do further fixups and it looks
sane on review - if people encounter issues in test could you please
submit incremental patches?  Thanks!
