From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Hercules Game Theater - cs4630
Date: Thu, 4 Jul 2002 11:20:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207041118360.757-100000@pnote>
References: <3D23675F.7070204@cucumelo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D23675F.7070204@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Jul 2002, Benny Sjostrand wrote:

>   My first thought was that it would be a easy match to make the
> Hercules Game Theater XP sound card work on Linux. My goal is to make
> the SPDIF IN-OUT interface work, and the multichannel PCM improving the
> current alsa cs46xx driver, and then go on with other advanced codec
> stuffs (hopefully finish before i die ...)
> Now a couple of days browsing the alsa source code and reading a lot
> of borring HW datasheet of must all Cirrus CS4xxx chips it just dont
> feel possible to find any easy solution.
> In the Cirrus collection of manuals and datasheet i have found a lot
> HW specifications and reference design documents for the CS4630 chip,
> and the codecs CS4694, CS4697 and so on. But what about the programmers
> guide, does it not exist any open document like "CS4630 Programmers
> Manual", or something similar, where it explain how to program the DSP
> ?? or is that not public ???
> Then i've sent mail to Cirrus and Hercules, of course without any
> response (yet) ....
> 
> I supose that people from the alsa-group has alreayd gone throw
> those issues, please maybe if you help me, where i find related
> documents about the CS430 chip, that can provide me necesary information
> to go on with the ALSA-driver.

I recommend to forget to do something with this chip. The company is not 
willing officially to co-operate to give us full specification for this 
hardware.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
