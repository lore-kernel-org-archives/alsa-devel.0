From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v3 1/2] thinkpad-acpi: Try to use full software mute
 control
Date: Tue, 9 Dec 2014 17:53:42 -0200
Message-ID: <20141209195342.GC361@khazad-dum.debian.net>
References: <cover.1413590510.git.luto@amacapital.net>
 <378856925c5ceecd27a6490585ee60362a714ef6.1413590510.git.luto@amacapital.net>
 <20141031230700.GA11745@khazad-dum.debian.net>
 <CALCETrWbu6NUFo2gv+gNEPATm=1jnLRY16iEvv7ZV-3TicZR_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWbu6NUFo2gv+gNEPATm=1jnLRY16iEvv7ZV-3TicZR_A@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@mit.edu>
List-Id: alsa-devel@alsa-project.org

On Mon, 08 Dec 2014, Andy Lutomirski wrote:
> On Fri, Oct 31, 2014 at 4:07 PM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:

...

> >> Signed-off-by: Andy Lutomirski <luto@mit.edu>
> >
> > Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> What tree do these go through?  I haven't spotted them in linux-next.

X86 PLATFORM DRIVERS
M:      Darren Hart <dvhart@infradead.org>
L:      platform-driver-x86@vger.kernel.org
T:      git
git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git
S:      Maintained
F:      drivers/platform/x86/

Darren, could you pick up this patch series, please?

You were missing in the Cc list, and it seems to have fallen through the
cracks  :-(

Maybe we could use https://patchwork.kernel.org/ for platform-driver-x86 ?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
