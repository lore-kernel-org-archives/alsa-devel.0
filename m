From: "John S. Denker" <jsd@monmouth.com>
Subject: Re: ALSA-drivers-writing howto updated
Date: Tue, 10 Dec 2002 17:10:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF66645.6090305@monmouth.com>
References: <s5hsmx57nij.wl@alsa2.suse.de> <3DF638A5.3060004@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmx57nij.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:

> I have added a link to the documentation page now.

I assume the page in question is:
   http://www.alsa-project.org/documentation.php3

That is a useful page.

Suggestion:  Include that page, verbatim, in the
distribution, in
  -- lib/doc/
  -- driver/alsa-kernel/Documentation/
  -- driver/doc/
(Why are the last two distinct???)

Also, please mention it (giving its online location
AND its distributed-file locations) in
  -- driver/README
  -- driver/doc/README.1st
  -- lib/README

This makes it more likely that folks will be
able to find it when they need it.



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
