From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [PATCH] Tascam US-224/428 MMC Implementation
Date: Mon, 2 Aug 2004 13:12:15 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32825.192.168.1.5.1091448735.squirrel@192.168.1.5>
References: <32814.192.168.1.8.1091390483.squirrel@192.168.1.8>
    <32820.192.168.1.8.1091391304.squirrel@192.168.1.8>
    <s5hy8kxsqks.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8kxsqks.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Karsten Wiese <annabellesgarden@yahoo.de>, martin-langer@gmx.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> At Sun, 1 Aug 2004 21:15:04 +0100 (WEST),
> Rui Nuno Capela wrote:
>>
>> Hi everybody,
>>
>> This is my latest patch against the alsa-tools tree (as of todays CVS
>> HEAD), regarding the us428control MMC implementation as for the Tascam
>> US-224/428 audio/midi USB control surfaces:
>>
>>     us428control now bumps to version 0.4.4.
>
> Patch applied.  Thanks!
>
> Takashi

BTW, I think this has been asked before but didn't had the chance to know
the right answer, so what's keeping snd-usb-usx2y out of the stock 2.6
kernel.org tree?

Anything to do with firmware licensing? IIRC there's already a GPL'd
bootstrap loader...

Regards.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
