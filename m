From: "Yong, Chee Yeew " <Chee-Yeew.Yong@thalesgroup.com>
Subject: RE: snd_mixer_gid_t??
Date: Tue, 3 Aug 2004 09:45:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <51BF576D5A02CC4CB2591F50994FD76691CBDD@nts013.uk.trt.thales>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'James Courtier-Dutton' <James@superbug.demon.co.uk>, 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for the info.

I am installing the Robust Audio Tool program. See:
http://www-mice.cs.ucl.ac.uk/multimedia/software/rat/index.html

Chee

> -----Original Message-----
> From: James Courtier-Dutton [mailto:James@superbug.demon.co.uk]
> Sent: 02 August 2004 18:11
> To: Yong, Chee Yeew 
> Cc: alsa-user@lists.sourceforge.net; 
> 'alsa-devel@lists.sourceforge.net'
> Subject: Re: [Alsa-devel] snd_mixer_gid_t??
> 
> 
> Yong, Chee Yeew wrote:
> > Hello,
> > 
> > Does anyone know in which library is the "snd_mixer_gid_t" 
> struct located?
> > 
> > I tried to install a program that utilises the soundcard, and during
> > compilation it is complaining that it does not know what a 
> "snd_mixer_gid_t"
> > type is. The only references that I have found on the web regarding
> > snd_mixer_gid_t is alsa. 
> > 
> > Does anyone know how to fix the program? Should I be including other
> > libraries?
> > 
> > Thank you!
> > 
> > C
> > 
> 
> snd_mixer_gid_t is not used by alsa any more.
> 
> What is the application you are trying to install.
> It probably needs upgrading to the latest alsa api.
> 
> James
> 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
