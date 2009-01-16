From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Fri, 16 Jan 2009 16:16:33 +0000
Message-ID: <20090116161633.GJ7554@sirena.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de> <497070D1.50301@mnementh.co.uk>
	<20090116115408.GB7554@sirena.org.uk>
	<49708E21.1060800@mnementh.co.uk>
	<20090116143135.GG7554@sirena.org.uk>
	<4970ABCB.5050300@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ED1F224353
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 17:16:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4970ABCB.5050300@mnementh.co.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 16, 2009 at 03:46:19PM +0000, Ian Molton wrote:

> Mark, the changes requested are implemented below. There are two 
> patchsets, one for wm9705 and one for the other codec issues I found.

> also available at:

> git://git.mnementh.co.uk/linux-2.6-im.git asoc-pu

Thanks, I've applied the first and squashed it down, will look at the
second one later.

It looks like your MUA has badly whitespace damaged the patches - it's
word wrapped them and it looks like tabs and spaces have been confused.
Might be worth using git send-email to send patches.
