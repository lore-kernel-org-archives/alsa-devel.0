From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v3 1/2] thinkpad-acpi: Try to use full software mute
 control
Date: Thu, 4 Dec 2014 03:50:31 -0800
Message-ID: <20141204115031.GC100190@vmdeb7>
References: <cover.1413590510.git.luto@amacapital.net>
 <378856925c5ceecd27a6490585ee60362a714ef6.1413590510.git.luto@amacapital.net>
 <20141031230700.GA11745@khazad-dum.debian.net>
 <CALCETrWbu6NUFo2gv+gNEPATm=1jnLRY16iEvv7ZV-3TicZR_A@mail.gmail.com>
 <20141209195342.GC361@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141209195342.GC361@khazad-dum.debian.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andy Lutomirski <luto@amacapital.net>, Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@mit.edu>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 09, 2014 at 05:53:42PM -0200, Henrique de Moraes Holschuh wrote:
> On Mon, 08 Dec 2014, Andy Lutomirski wrote:
> > On Fri, Oct 31, 2014 at 4:07 PM, Henrique de Moraes Holschuh
> > <hmh@hmh.eng.br> wrote:
> 
> ...
> 
> > >> Signed-off-by: Andy Lutomirski <luto@mit.edu>
> > >
> > > Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > 
> > What tree do these go through?  I haven't spotted them in linux-next.
> 
> X86 PLATFORM DRIVERS
> M:      Darren Hart <dvhart@infradead.org>
> L:      platform-driver-x86@vger.kernel.org
> T:      git
> git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git
> S:      Maintained
> F:      drivers/platform/x86/
> 
> Darren, could you pick up this patch series, please?
> 
> You were missing in the Cc list, and it seems to have fallen through the
> cracks  :-(
> 
> Maybe we could use https://patchwork.kernel.org/ for platform-driver-x86 ?

For the time being, please continue to Cc the maintainer on all patches. That's
a minimum requirement anyway. I'm not opposed to discussing patchwork, but I
don't want it to be a substitute to following standard mailing list practices.

-- 
Darren Hart
Intel Open Source Technology Center
