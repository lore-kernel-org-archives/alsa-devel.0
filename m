From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: current buglets
Date: Thu, 15 Aug 2002 10:52:19 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208151752.KAA03176@cmn29.stanford.edu>
References: <E17fMzs-0005hC-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17fMzs-0005hC-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> hdsp
> - cold+warm boot required to get output working
> - 96kHz and 88.2kHz not accessible via PCM interface

- interaction between number of channels and sample rate
  (setting one should restrict the other to the "legal" values)
- could not get it to work with external sync, tried both adat and
  word clock (I sent a message to the list about this).

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
