From: iriXx <m@iriXx.org>
Subject: Re: xine & cvs alsa
Date: Mon, 27 Jan 2003 14:47:30 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E354682.6090605@iriXx.org>
References: <20030127142506.GA18353@earthlink.net>
Reply-To: m@iriXx.org
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

i've had this under mandrake 9.0 with the supplied release too.... :(

m~

despair@adelphia.net wrote:
> For a week, maybe a bit more (I didn't watch any movies for over a week,
> and haven't had time to try searching cvs to pin down the date) xine has
> been dying when I try to watch movies in 4.0, 5.0, or 5.1. Stereo works
> without any problems, though.
> 
> Here's the error message:
> audio_alsa_out: Audio Device name = surround40
> audio_alsa_out: Number of channels = 4
> ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for symbol _snd_pcm_hook_ctl_elems_install
> ALSA lib pcm_hooks.c:527:(snd_pcm_hook_add_conf) symbol _snd_pcm_hook_ctl_elems_install is not defined inside (null)
> xiTK received SIGSEGV signal, RIP.
> Aborted
> 
> Is this an API change, xine doing something shifty that it got away with
> up until now, or something else entirely? Anything I can do to work around
> it? Movies just aren't the same in stereo... :)
> 
> Thanks,
> Ragnvald Maartmann-Moe IV
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 


-- 
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

  _
( )  ascii ribbon against html email
  X
/ \    cat /dev/sda1 > /dev/dsp


   *** stopping make sense ***



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
