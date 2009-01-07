From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add new DAPM control
Date: Wed, 7 Jan 2009 13:57:58 +0000
Message-ID: <20090107135757.GA12359@rakim.wolfsonmicro.main>
References: <49641588.7050703@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 100F12436B
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 14:57:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49641588.7050703@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 07, 2009 at 02:38:00AM +0000, Ian Molton wrote:

> The attached patch adds a new mixer control that allows cleaner support
> for the wm9705 codec Im working on. I think it probably has wider uses
> though.

Applied, thanks.

It'd be handy if you could post patches in the format suggested by
Documentation/SubmittingPatches (unless your e-mail client would mangle
them) with descriptive text after the ---.  This helps with automated
tools like git am.
