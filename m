From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Patch to enable IR on Audigy 2 Drive
Date: Mon, 10 Mar 2003 23:22:25 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303102322.25075.adq_dvb@lidskialf.net>
References: <200303102231.31227.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303102231.31227.adq_dvb@lidskialf.net>
Content-Disposition: inline
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

Oh, BTW, you have to use /dev/snd/midiC0D1 for it to work with lircd.. the 
/dev/midi, /dev/midi00, /dev/sequencer OSS compatability layers DO NOT work.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
