From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP
Date: Tue, 10 Dec 2002 00:12:40 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Lcb7-000644-00@sc8-sf-list1.sourceforge.net>
References: <1039496025.1342.62.camel@Godzilla>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "09 Dec 2002 20:53:44 PST."
             <1039496025.1342.62.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, Alsa-List <linux-audio-user@music.columbia.edu>
List-Id: alsa-devel@alsa-project.org

>3) When I boot I see the following message in /var/log/messages
>
>Dec  9 12:39:40 Godzilla kernel: Hammerfall memory allocator: buffers
>allocated for 1 cards
>Dec  9 12:39:40 Godzilla kernel: RME Hammerfall-DSP: no cards found
>Dec  9 12:39:40 Godzilla insmod:
>/lib/modules/2.4.19-1.ll/kernel/drivers/sound/pci/rme9652/snd-hdsp.o:
>init_module: No such device

are you sure you have the new module installed? i know of at least 2
people using the patch you have used that have got their new 9652's working.

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
