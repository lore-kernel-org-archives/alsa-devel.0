From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Check list debugfs files for
 PAGE_SIZE overflow
Date: Wed, 13 Oct 2010 10:58:07 +0100
Message-ID: <20101013095807.GJ6424@rakim.wolfsonmicro.main>
References: <1286963197-9477-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1286963463.3282.32.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 655912447D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 11:58:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286963463.3282.32.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 10:51:03AM +0100, Liam Girdwood wrote:

> Looks like you have the DAI id fix in here too. I assume this is mean to
> be a separate patch ?

That's git stash misbehaving.  Fixed up locally.
