From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: A couple of hardware problems
Date: Tue, 14 Jan 2003 14:34:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030114143440.GW22132@ecs.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The first one is not a problem with alsa, but I haven't been able to find
any mention of it online, so I wonrdered if anyone has any insight into it.

I have a motherboard with a via82xx chipset [KT333] on it, the bios will
only alow me to select "auto" or "disabled" for the sound device, and
neither seems to make the device appear to lspci, Is it possible that the
motherboard is disabling it becasue it's detected my other soundcards?

The other I dont know about: I bought an ESS Solo1 based card (Terratec
128i PCI) to use the MIDI port, but it doesn't appear to work for MIDI
input. I've been messing with it for a couple of days and I'm ready to
give up and swap it for an old ens1371 based card. If anyone has anything
I should try before swtiching it please say.

My alsa-driver version is "based on the experimental CVS version of alsa,
the source was downloaded on 20021216.102029", as supplied by CCRMA.

- Steve


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
