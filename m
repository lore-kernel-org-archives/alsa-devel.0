From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: M-Audio firewire device
Date: Tue, 2 Sep 2003 14:48:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030902134842.GK29782@ecs.soton.ac.uk>
References: <20030902085428.GA29782@ecs.soton.ac.uk> <1062506521.27592.5.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1062506521.27592.5.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 02, 2003 at 05:42:01 -0700, Mark Knecht wrote:
> On Tue, 2003-09-02 at 01:54, Steve Harris wrote:
> > http://www.m-audio.com/products/m-audio/fw410.php
> > 
> > Maybe the first supported firewire audio device for alsa? If M-Audio give
> > up the details. Could be a better option for laptop use than USB.
> 
> I'm going to guess that the issue is that this is probably an MLAN
> device. The MLAN spec comes under NDA from Yamaha. I have a copy at
> work. The problem is how do we get a driver to support it?

I was assuming it would be a radom proprietary format - maudio werent very
good at sticking to th USB specs either IIRC.

If it is mLAN its only the service discovery stuff thats under NDA - and
they've been trying to get that standardised too, so it might be free-able
by now.

- Steve


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
