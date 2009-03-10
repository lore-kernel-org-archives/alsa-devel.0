From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] pxa-ssp: don't touch ssp
	registers	when stream is running
Date: Tue, 10 Mar 2009 15:56:00 +0000
Message-ID: <20090310155559.GD12297@sirena.org.uk>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<20090304203350.GB10731@sirena.org.uk>
	<20090304203911.GA18917@buzzloop.caiaq.de>
	<20090304204222.GC10731@sirena.org.uk>
	<20090305102337.GB28448@buzzloop.caiaq.de>
	<20090310154100.GB10574@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 01DF8103871
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 16:56:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090310154100.GB10574@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 10, 2009 at 04:41:00PM +0100, Daniel Mack wrote:

> Could you have a look on the patch below please - does that look better?

Looks good, I'll apply this.
