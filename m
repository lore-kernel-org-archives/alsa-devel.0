From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [Sound-open-firmware]  [ANNOUNCE] SOF 1.0 Release
Date: Wed, 10 Jan 2018 09:31:16 +0000
Message-ID: <1515576676.1844.245.camel@linux.intel.com>
References: <1515525458.1844.203.camel@linux.intel.com>
 <s5ha7xmyx7m.wl-tiwai@suse.de>
 <06f9354e-99cb-6324-12e9-e184fad78d25@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <06f9354e-99cb-6324-12e9-e184fad78d25@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-01-10 at 09:08 +0100, Jaroslav Kysela wrote:
> Dne 10.1.2018 v 08:44 Takashi Iwai napsal(a)
> > 
> > Do you plan for a classical tarball release, or it's only over git
> > repo?  I'm asking it since I'm considering to package for distro.
> 
> I can create and host the tarballs on alsa-project.org. Liam, could you
> add missing pieces to Makefile.am for 'make dist'?
> 

Ah, this is missing some files as everyone's been using git, I'll fix
today.

Thanks

Liam
