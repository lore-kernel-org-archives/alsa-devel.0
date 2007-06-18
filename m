From: Malte Cornils <malte@cornils.net>
Subject: Re: [1/2] 2.6.22-rc5: known regressions
Date: Mon, 18 Jun 2007 13:02:42 +0200
Message-ID: <200706181302.42951.malte@cornils.net>
References: <467543E1.1060001@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762916AbXFRLDJ@vger.kernel.org>
In-Reply-To: <467543E1.1060001@googlemail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Rodrigo Luiz <troops.of.doom@gmail.com>, "Darrick J. Wong" <djwong@us.ibm.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-pci@atrey.karlin.mff.cuni.cz, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello,

Am Sonntag, 17. Juni 2007 16:23 schrieb Michal Piotrowski:
> Here is a list of some known regressions in 2.6.22-rc5.
> PCI
>
> Subject    : PCI setup hangs on Asus Notebook (nolapic helps)
> References : http://lkml.org/lkml/2007/6/14/161
> Submitter  : Malte Cornils <malte@cornils.net>
> Status     : unknown

The original report was made on 2.6.22-rc3, I just checked and it still 
happens on 2.6.22-rc5.

Yours
-Malte Cornils
