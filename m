From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Sun, 13 Apr 2003 20:21:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E99AAAB.1070101@cucumelo.org>
References: <20030408205515.GB6940@ulima.unil.ch> <3E933EF6.5030601@superbug.demon.co.uk> <3E93C4CA.4080604@cucumelo.org> <20030409082815.GA14489@ulima.unil.ch> <s5h65poq65j.wl@alsa2.suse.de> <20030409114312.GE14489@ulima.unil.ch> <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org> <20030413170501.GA2323@ulima.unil.ch>
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
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>I have patched my CVS with your patch, then made a
>./cvscompile --with-sequencer=yes --with-cards=cs46xx --with-isapnp=no
>and sudo make install
>  
>
Could you recompile with "--with-debug=detect" and try send my some logs 
while you doing your tests ?

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
