From: Steve Harris <S.W.Harris-jaJdc+oKuOm+cE1VCfRBVw@public.gmane.org>
Subject: Re: [Alsa-devel] Firewire Audio Card Support
Date: Thu, 18 Nov 2004 14:32:05 +0000
Message-ID: <20041118143205.GA21282@login.ecs.soton.ac.uk>
References: <31148074.1100630541337.JavaMail.root@scooter.psp.pas.earthlink.net>
	<419C9D47.4090606@x-i.net>
	<200411181515.52218.olaf@solutionworks.de>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200411181515.52218.olaf-Cb7RZHV19h6Y/VGTjfr9Sg@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 18, 2004 at 03:15:52 +0100, Olaf Christ wrote:
> Hi,
> 
> as the owner of a firewire audio card (Motu 828mkII) I was disappointed when 
> trying to use it under linux. Asking Motu to provide tech docs and/or linux 
> drivers is useless: "We will possibly release linux drivers in the future, 
> but we never release any kind of technical documentation."

That is actually a big improvemnt. When we (linuaudio.org) were demoing at
Sounds Live in London earlier this year, the were telling thier users that
they had no intention of supporting linux, and wouldn't release docs.

Though with the number of thier users we were sending to them to ask, I
guess they were getting a bit concerned :)

- Steve

> Is there any effort to join forces for putting pressure on the manufacturers 
> yet? I am willing to create an address list ordered by audio card 
> manufacturer/model to make the manufacturers realize there is a need for 
> linux support.
> 
> Any comments?
> 
> Olaf
> 
> 
> 
> On Thursday 18 November 2004 14:01, derek holzer wrote:
> > Of course, the Firewire subsystem for Linux works fine. But AFAIK there
> > are no drivers existing for any firewire audio cards. Bug the various
> > manufacurers to release more technical info and they might eventually
> > show up.
> >
> > d.
> >
> > Victor LaLoggia wrote:
> > > Hello Frank;
> > >
> > >   Thank you for your response, and I do not mean to be contrary, but what
> > > about the work the folks at http://www.linux1394.org/ are doing?
> > >
> > >   I see that their subsystem has been included Linux kernel sources since
> > > version 2.3.40.  Does the subsystem not work?
> > >
> > >   Thanks,
> > >   vic
> > >
> > > -----Original Message-----
> > > From: Frank Barknecht <fbar-T1uUCcFPrxNAfugRpC6u6w@public.gmane.org>
> > > Sent: Nov 15, 2004 12:14 PM
> > > To: linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
> > > Subject: Re: [linux-audio-user] Using Linux Laptop for Live Performance
> > >
> > > Hallo,
> > >
> > > Victor LaLoggia hat gesagt: // Victor LaLoggia wrote:
> > >>  I am just beginning my research into the available software and
> > >>  hardware, and would greatly appreciate any information. Especially
> > >>  on hardware - what would be the best usb/ firewire interface for
> > >>  live performance?
> > >
> > > No Firewire audio yet on Linux. The best in your case is PCMCIA, which
> > > has the lowest latency. VX-Pocket or RME cards are good choices. Also
> > > try, if your internal soundcard is enough.
> > >
> > > Ciao
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
