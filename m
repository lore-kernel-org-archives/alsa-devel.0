From: Olivier Ricordeau <olivier.ricordeau@wanadoo.fr>
Subject: Re: [BUG] buggy ali5451 driver
Date: Mon, 04 Nov 2002 15:45:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC68814.6070700@wanadoo.fr>
References: <m24raxpndj.fsf@vador.mandrakesoft.com> <s5hu1ixa0eu.wl@alsa2.suse.de> <3DC68350.2040208@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Olivier Ricordeau wrote:
> I can... if you explain me how to do this... A kernel option at boot 
> time ?. Though I've used Linux for a few years, I'm quite a newbie 
> regarding kernel stuffs.

Ok I've searched the web, and I've tried to boot my standard MDK kernel 
with the "acpi=off", and it's the same: both "modprobe trident" and 
"modprobe snd-ali5451" make the laptop freeze (I/O errors on hard drive).

-- 

  -= *Olivier RICORDEAU* =-   |  ICQ: 65452304
  Ing1 EPITA Millesime 2005   | Phone: 0686720852
           olivier.ricordeau@wanadoo.fr
          _Might the source be with you_



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
