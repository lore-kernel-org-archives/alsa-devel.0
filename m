From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PROBLEM: snd-au8830: dead after software suspend
Date: Sat, 4 Aug 2007 11:46:18 +0200
Message-ID: <200708041146.18682.rjw@sisk.pl>
References: <46B3A4F5.2000708@gert.robben.nu> <46B3C44D.7020801@gert.robben.nu> <46B3CDA0.90804@gert.robben.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764499AbXHDJh1@vger.kernel.org>
In-Reply-To: <46B3CDA0.90804@gert.robben.nu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Gert Robben <lkml@gert.robben.nu>
Cc: alsa-devel@alsa-project.org, mjander@embedded.cl, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Saturday, 4 August 2007 02:51, Gert Robben wrote:
> >>> Have you reported this to the ALSA people?
> >> No, I thought this might as well be something for PCI or PM people, and 
> >> I expected some ALSA people are also reading this list.
> >> If not, where else should I report this exactly?
> > alsa-devel [...] the author of the driver
> Done (original message below). Thanks again :)

You also may want to file a bug at http://bugzilla.kernel.org .

If you decide to do that, please file it as
"Power Management"->Hibernation/Suspend bug, I'll redirect it to the ALSA
people.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
