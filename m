From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: intel 8x0 went silent in 2.6.11
Date: Thu, 03 Mar 2005 13:51:40 +0100
Message-ID: <4227085C.7060104@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just upgraded to Linux 2.6.11 and the soundcard on my machine went 
silent. All volume controls are correct and there are no errors 
reported. But no sound coming from the speakers. And here's the kicker, 
the headphones work fine!
2.6.10 still works so the bug appeared in one of the patches in between.
The sound card is the one integrated into intels mobile ICH4 chipset.

Rgds
Pierre
