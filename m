From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: output file while using digiface
Date: Tue, 14 Sep 2004 08:38:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409141238.i8ECcO3T005836@localhost.localdomain>
References: <20040914074653.74562.qmail@web12903.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 14 Sep 2004 00:46:53 PDT."
             <20040914074653.74562.qmail@web12903.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sonal Mane <manesonal@yahoo.com>
Cc: alsa-announce@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>   this is to ask if anyone has used the digiface midi interface of the hammer
>fall series. i wanted to know what is the format of the midi file after the mi
>di is read by the driver. is it rawmidi or formatted midi.? 

i think you're a little confused. why don't you try restating that
question. if you mean "when my program reads data from the MIDI port,
does it get a Standard MIDI File or just raw MIDI bytes?", the answer
is raw MIDI bytes, for this and every other MIDI port on Linux and
every other operating system i have ever heard of.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
