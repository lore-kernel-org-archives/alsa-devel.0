From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: config problem
Date: Wed, 26 Nov 2003 16:33:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031126163300.4946c69a.pochini@shiny.it>
References: <20031125191438.45a1f01b.pochini@shiny.it>
	<s5h65h8z2m2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65h8z2m2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 25 Nov 2003 20:09:57 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> for building multiple drivers with a common core/library module, you
> can find an example in isa/sb directory.  there snd-sb-common is
> shared among several different top-level modules.  (usually, the
> common module is named snd-xxx-lib, though.)

Done, tnx.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
