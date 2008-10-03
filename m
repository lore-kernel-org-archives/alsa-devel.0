From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.27?] ASoC: Correct inverted Mic
	PGA	Switch control in wm8510 driver
Date: Fri, 3 Oct 2008 18:47:14 +0100
Message-ID: <20081003174714.GA15409@rakim.wolfsonmicro.main>
References: <1223041684-4449-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<48E65475.3040203@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39DC324343
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 19:47:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E65475.3040203@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 03, 2008 at 10:20:53AM -0700, Troy Kisky wrote:

> Why the WM509 prefix instead of WM8510?

Gah.  Because I sent an incorrect, buggy, version of the patch.  Trying
to do too many things at once :/

Takashi, please don't apply.
