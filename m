From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Example app source code or docs needed to help me do mmap.
Date: Sat, 27 Apr 2002 01:29:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CC9F106.8020806@superbug.demon.co.uk>
Reply-To: James@superbug.demon.co.uk
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Can someone point me to an example alsa app doing mmap ?

I want to convert my application from plain pcm_write  to mmap mode.
I would also like to understand how you detect if a sound card can do 
mmap or not.

I help develope a multimedia application, and 6 audio channels (5.1 
sound) starts to require mmap mode on very slow PCs.

Cheers
James
