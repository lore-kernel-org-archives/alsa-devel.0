From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: more info
Date: Wed, 24 Apr 2002 17:05:20 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020425000520.44054.qmail@web11503.mail.yahoo.com>
References: <s5h8z7dghjn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z7dghjn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

Could anyone point to me a reference for the following (or explain to me
directly what is the purpose of each of those functions) in the PCM module:

	prepare:	snd_xxxx_capture_prepare,
	trigger:	snd_xxxx_trigger,
	pointer:	snd_xxxx_pointer,
	copy:		snd_xxxx_capture_copy,
	silence:	snd_xxxx_capture_silence,

Plus, what is the fifo size (e.g. on the card)?

Thanks,
Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Games - play chess, backgammon, pool and more
http://games.yahoo.com/
