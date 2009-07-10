From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: codec drivers for Cirrus CS8406 or Texas
 Instruments PCM1748
Date: Fri, 10 Jul 2009 20:29:53 +0100
Message-ID: <20090710192952.GC5916@sirena.org.uk>
References: <782593.49297.qm@web51102.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D3112440D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 21:29:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <782593.49297.qm@web51102.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: just4emmett <just4emmett@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 07, 2009 at 09:24:27AM -0700, just4emmett wrote:

> Hello all.  Is anyone working on codec drivers for these devices, or
know where to find them if they exist already?  Checked
http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=tree;f=sound/soc/codecs;h=21a5f9dd8d8d2fccf74ea1d0122b7551e51374dc;hb=dev
and didn't see anything.  Thanks!

I've never heard of anything, sorry.  Neither of the CODECs looks like
they have very much control so it should be relatively straightforward
to produce drivers yourself if you need to.
