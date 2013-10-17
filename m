From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v2 1/3] thinkpad-acpi: Add mute and mic-mute LED
 functionality
Date: Thu, 17 Oct 2013 08:34:12 -0300
Message-ID: <20131017113412.GC18254@khazad-dum.debian.net>
References: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
 <1381957833-13788-2-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381957833-13788-2-git-send-email-david.henningsson@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Oct 2013, David Henningsson wrote:
> The LEDs are currently not visible to userspace, for security
> reasons. They are exported through thinkpad_acpi.h for use by the
> snd-hda-intel driver.
> 
> Thanks to Alex Hung <alex.hung@canonical.com> and Takashi Iwai
> <tiwai@suse.de> for writing parts of this patch.
> 
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
