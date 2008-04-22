From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Tue, 22 Apr 2008 11:32:31 +0100
Message-ID: <20080422103231.GA15198@rakim.wolfsonmicro.main>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
	<20080419004103.GA29770@buzzloop.caiaq.de>
	<20080419112425.GA18877@sirena.org.uk>
	<20080419121838.GA1680@buzzloop.caiaq.de>
	<20080419145005.GA23492@sirena.org.uk>
	<20080419162418.GA3177@buzzloop.caiaq.de>
	<20080422095204.GA9268@rakim.wolfsonmicro.main>
	<20080422100430.GA25562@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A09042458D
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 12:32:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080422100430.GA25562@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 22, 2008 at 12:04:30PM +0200, Daniel Mack wrote:

> No, that's actually final from my side. Here we go.

Looks like you've generated this against a kernel with the clocking
stuff applied:

Applying asoc tlv320aic3x: add GPIO support
error: patch failed: sound/soc/codecs/tlv320aic3x.h:108
error: sound/soc/codecs/tlv320aic3x.h: patch does not apply
Patch failed at 0001.
