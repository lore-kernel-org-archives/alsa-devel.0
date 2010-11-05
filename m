From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] sound card dir under debugfs
Date: Fri, 5 Nov 2010 14:46:03 -0400
Message-ID: <20101105184603.GC9139@opensource.wolfsonmicro.com>
References: <1288982121-22201-1-git-send-email-jhnikula@gmail.com>
	<20101105183616.GB9139@opensource.wolfsonmicro.com>
	<20101105203907.006fef26.jhnikula@gmail.com>
	<20101105183936.GA29680@sirena.org.uk>
	<20101105204146.387fc095.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21A4524406
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 19:45:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101105204146.387fc095.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 08:41:46PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Please resubmit the stuff you're depending on.

> Only dependency is this which got applied as far as I got it:

> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033419.html

Oh, in which case there's no need to note the dependency since it's
already in the tree :)  Saying something like "recently merged" helps
here - otherwise I'll tend to read a message like that as saying that
the patch can't currently be applied due to other outstanding work.
